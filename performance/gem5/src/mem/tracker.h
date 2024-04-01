#ifndef TRACKER_H
#define TRACKER_H

#include <iostream>
#include <vector>
#include <algorithm>

class Tracker {
  private:
    int max_size;
    std::vector<int> tracker;
    int num_valid;
    int head;
    int tail;
    long long num_remove;
    long long num_evict;
    long long num_insert;

  public:
    Tracker(int size=6) : max_size(size), num_valid(0), head(0), tail(0), num_remove(0), num_evict(0), num_insert(0) {
        tracker.resize(size, -1);
    }

    void Init( int size )
    {
        tracker.resize(size, -1);
    }
    

    int issue_mitig() {
        num_remove++;
        return remove();
    }

    void insert(int addr) {
        if (num_valid == max_size) {
            num_evict++;
            remove();
        }

        tracker[tail] = addr;
        tail = (tail + 1) % max_size;
        num_valid++;
        num_insert++;
    }

    void Stats() {
        double loss_prob = num_evict / static_cast<double>(num_insert);
        std::cout << std::endl;
        std::cout << "Tracker Stats:" << std::endl;
        std::cout << "\tTotal Insert: " << num_insert << std::endl;
        std::cout << "\tTotal Evict:  " << num_evict << std::endl;
        std::cout << "\tTotal Remove: " << num_remove << std::endl;
        std::cout << "\tLoss Rate:    " << loss_prob << std::endl;
        std::cout << std::endl;
    }

    long long get_num_remove() { return num_remove; }
    long long get_num_insert() { return num_insert; }
    long long get_num_evict() { return num_evict; }

  private:
    int remove() {
        int vic = -1;
        if (num_valid > 0) {
            vic = tracker[head];
            head = (head + 1) % max_size;
            num_valid--;
        }
        return vic;
    }
};


#endif
