#!/usr/bin/env python3
"""Generate a C++ test from the actual patched delayed-opponent-state block.

Only the engine setters and the surrounding game environment are mocked. The
queue control flow and memmove statements are extracted verbatim from source.
"""
import argparse
import re
from pathlib import Path

from delay_queue_patch import BEGIN, END, OLD, NEW


def generate(source):
    data = source.read_bytes()
    if data.count(BEGIN) != 1 or data.count(END) != 1:
        raise ValueError('Delayed-state section not unique')
    start = data.index(BEGIN) + len(BEGIN)
    stop = data.index(END)
    section = data[start:stop]
    if section.count(OLD) or section.count(NEW) != 1:
        raise ValueError('Source must contain exactly one corrected shift')
    if section.count(b'if(delay == 0)') != 1 or section.count(b'memmove(') != 3:
        raise ValueError('Delayed-state code shape changed')
    section = re.sub(rb'//[^\r\n]*', b'', section).decode('ascii')
    return PREFIX + '\n' + section + '\n' + SUFFIX


PREFIX = r'''
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <deque>
#include <vector>

struct Data { short action, act_block; int frame; };
struct MockEngine {
    int action, block, frame;
    void setScriptValue(const char* name, int value) {
        if (std::strcmp(name, "enemy_act") == 0) action=value;
        else if (std::strcmp(name, "enemy_act_block") == 0) block=value;
        else if (std::strcmp(name, "enemy_frame") == 0) frame=value;
        else { std::fprintf(stderr, "Unexpected setter: %s\n", name); std::exit(1); }
    }
};
void run_original_block(int delay, short* act, short* act_block, int* frame,
                        Data enemy_data, MockEngine* engine) {
'''

SUFFIX = r'''
}
void check(bool condition, const char* label, int delay, int step) {
    if (!condition) { std::fprintf(stderr, "%s delay=%d step=%d\n", label,delay,step); std::exit(1); }
}
void exercise(int delay) {
    const short short_guard=-23456;
    const int int_guard=-123456789;
    std::vector<short> actions(delay+2,0), blocks(delay+2,0);
    std::vector<int> frames(delay+2,0);
    actions.front()=actions.back()=short_guard;
    blocks.front()=blocks.back()=short_guard;
    frames.front()=frames.back()=int_guard;
    std::deque<Data> expected(delay,Data{0,0,0});
    for (int step=0;step<120;step++) {
        Data current{static_cast<short>(1000+step),static_cast<short>(2000+step),3000+step};
        Data want = delay ? expected.front() : current;
        MockEngine out{-1,-1,-1};
        run_original_block(delay, delay ? &actions[1] : NULL,
                           delay ? &blocks[1] : NULL, delay ? &frames[1] : NULL, current,&out);
        check(out.action==want.action,"wrong action",delay,step);
        check(out.block==want.act_block,"wrong block",delay,step);
        check(out.frame==want.frame,"wrong frame",delay,step);
        if (delay) { expected.pop_front(); expected.push_back(current); }
        check(actions.front()==short_guard && actions.back()==short_guard,"action boundary",delay,step);
        check(blocks.front()==short_guard && blocks.back()==short_guard,"block boundary",delay,step);
        check(frames.front()==int_guard && frames.back()==int_guard,"frame boundary",delay,step);
        for (int i=0;i<delay;i++) {
            check(actions[i+1]==expected[i].action,"action queue",delay,step);
            check(blocks[i+1]==expected[i].act_block,"block queue",delay,step);
            check(frames[i+1]==expected[i].frame,"frame queue",delay,step);
        }
    }
    std::printf("delay %d passed: 120 updates with guarded buffers\n",delay);
}
int main() {
    exercise(0); exercise(1); exercise(2); exercise(5); exercise(17);
    return 0;
}
'''


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--source', type=Path, default=Path('ai/th123_ai/main.cpp'))
    parser.add_argument('--output', type=Path, default=Path('verify-delay-queue-generated.cpp'))
    args = parser.parse_args()
    args.output.write_text(generate(args.source), encoding='ascii', newline='\n')
    print('Generated delayed-state integration harness:', args.output)
