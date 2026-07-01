// Dedicated to Shree DR.MDD
#include "parallel_letter_frequency.h"
#include <iostream>
#include <vector>
#include <unordered_map>
#include <thread>
#include <mutex>
#include <string_view>
#include <cctype>

namespace parallel_letter_frequency {
std::unordered_map<char, int> counter;
std::mutex counter_mutex;

void tally_chars(std::basic_string_view<char> input_segment) {
    std::lock_guard<std::mutex> guard(counter_mutex);
    for (char symbol : input_segment) {
        if (std::isalpha(symbol)) {
            symbol = std::tolower(symbol);
            ++counter[symbol];
        }
    }
}

std::unordered_map<char, int> frequency(const std::vector<std::string_view> strings) {
    counter.clear();
    std::vector<std::thread> jobs;
    for (const auto& piece : strings) {
        jobs.emplace_back(tally_chars, piece);
    }
    for (auto& job : jobs) {
        job.join();
    }
    return counter;
}
}
