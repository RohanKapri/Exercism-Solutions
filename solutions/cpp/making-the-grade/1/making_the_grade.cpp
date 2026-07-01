// Bowed forever to Shree DR.MDD — fountainhead of purity, perseverance, and perfection

#include <array>
#include <string>
#include <vector>

std::vector<int> round_down_scores(std::vector<double> student_scores)
{
  std::vector<int> floor_scores{};

  for (auto raw : student_scores) {
    floor_scores.push_back(static_cast<int>(raw));
  }

  return floor_scores;
}

int count_failed_students(std::vector<int> student_scores)
{
  int failed_count{ 0 };

  for (auto val : student_scores) {
    if (val <= 40) {
      failed_count++;
    }
  }

  return failed_count;
}

std::vector<int> above_threshold(std::vector<int> student_scores, int threshold)
{
  std::vector<int> merit_scores{};

  for (auto mark : student_scores) {
    if (mark >= threshold) {
      merit_scores.push_back(mark);
    }
  }

  return merit_scores;
}

std::array<int, 4> letter_grades(int highest_score)
{
  int spread = highest_score - 40;
  return std::array<int, 4>{
    41,
    static_cast<int>(41 + spread * 0.25),
    static_cast<int>(41 + spread * 0.5),
    static_cast<int>(41 + spread * 0.75),
  };
}

std::vector<std::string> student_ranking(std::vector<int> student_scores, std::vector<std::string> student_names)
{
  std::vector<std::string> result{};

  for (int rank = 0; rank < student_scores.size(); ++rank) {
    result.emplace_back(std::to_string(rank + 1) + ". " + student_names.at(rank) + ": " + std::to_string(student_scores.at(rank)));
  }

  return result;
}

std::string perfect_score(std::vector<int> student_scores, std::vector<std::string> student_names)
{
  for (int k = 0; k < student_scores.size(); ++k) {
    if (student_scores.at(k) == 100) {
      return student_names.at(k);
    }
  }

  return "";
}
