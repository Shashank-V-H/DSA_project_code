

#include <algorithm>
#include <cstdlib>
#include <ctime>
#include <iostream>
#include <string>
#include <vector>

struct Node {
  std::string name;
  int score;
};

std::vector<Node> g1, g2, g3;

// Function to get user input for a new node
Node getNode() {
  Node newNode;
  std::cout << "Enter the name: ";
  std::getline(std::cin >> std::ws, newNode.name);
  newNode.score = 0;
  return newNode;
}

// Function to sort a game scoreboard
void sortBoard(std::vector<Node> &board) {
  std::sort(board.begin(), board.end(), [](const Node &a, const Node &b) {
    return b.score < a.score; // Sort in descending order of scores
  });
}

// Function to display a game scoreboard
void displayBoard(const std::vector<Node> &board) {
  std::cout << "HIGH SCORE\n";
  std::cout << "--------------------------------\n";
  for (const auto &node : board) {
    std::cout << node.name << "\t" << node.score << "\n";
  }
  std::cout << "--------------------------------\n";
}

// Game 1: Guessing game
void guessNumber() {
  Node player = getNode();
  int a, b, score = 0;
  int x = 1;

  while (x != 0) {
    std::cout << "Guess the random number between 1-3: ";
    std::cin >> b;
    a = (rand() % 3) + 1;
    if (a == b)
      score++;
    else
      score--;
    std::cout << "\nYour current score is " << score << "\n";
    std::cout
        << "Enter\n(ANY NUMBER) to REPLAY\n<0> to EXIT this game\nEnter: ";
    std::cin >> x;
  }

  player.score = score;
  g1.push_back(player);
  sortBoard(g1);
  displayBoard(g1);
}

// Game 2: Cows and Bulls
void cowsAndBulls() {
  Node player = getNode();
  std::string words[] = {"cat", "dog", "ant", "bat", "hat", "pot", "pet"};
  std::string correctWord = words[rand() % 7];
  std::string guess;
  int bulls = 0, cows = 0, points = 0, quit = 0;

  while (true) {
    std::cout << "Enter 3 character word: >> ";
    std::cin >> guess;

    bulls = 0, cows = 0;
    for (int i = 0; i < 3; i++) {
      if (guess[i] == correctWord[i])
        bulls++;
      else if (correctWord.find(guess[i]) != std::string::npos)
        cows++;
    }

    if (bulls == 3) {
      std::cout << "The answer is correct\n";
      points++;
    } else {
      std::cout << "Bull=" << bulls << " Cow=" << cows << "\n";
    }

    std::cout << "Your current score is " << points << "\n";
    std::cout << "Enter\n<0> to QUIT\n<1> to REPLAY\nEnter: ";
    std::cin >> quit;
    if (quit == 0)
      break;
  }

  player.score = points;
  g2.push_back(player);
  sortBoard(g2);
  displayBoard(g2);
}

// Game 3: Rock, Paper, Scissors
void rockPaperScissors() {
  Node player = getNode();
  int rounds = 5, result = 0;

  std::cout << "Welcome to Rock Paper Scissors\n";
  for (int i = 0; i < rounds; i++) {
    int computer = rand() % 3;
    int playerChoice;
    std::cout << "Enter your choice [0=rock], [1=paper], [2=scissors]: ";
    std::cin >> playerChoice;

    if (playerChoice == computer) {
      std::cout << "Draw\n";
    } else if ((playerChoice == 0 && computer == 2) ||
               (playerChoice == 1 && computer == 0) ||
               (playerChoice == 2 && computer == 1)) {
      std::cout << "You won\n";
      result++;
    } else {
      std::cout << "You lost\n";
    }
  }

  std::cout << "Your final score is: " << result << "\n";
  player.score = result;
  g3.push_back(player);
  sortBoard(g3);
  displayBoard(g3);
}

int main() {
  srand(static_cast<unsigned int>(time(0))); // Seed the random number generator
  int choice = 0;

  while (choice != 4) {
    std::cout
        << "\n############### Welcome to Game Dashboard ###############\n";
    std::cout << "Select the game you want to play:\n";
    std::cout << "<1> Guess the Number\n";
    std::cout << "<2> Cows and Bulls\n";
    std::cout << "<3> Rock Paper Scissors\n";
    std::cout << "<4> Exit\n";
    std::cout << "Enter your choice: ";
    std::cin >> choice;

    switch (choice) {
    case 1:
      guessNumber();
      break;
    case 2:
      cowsAndBulls();
      break;
    case 3:
      rockPaperScissors();
      break;
    case 4:
      std::cout << "Goodbye!\n";
      break;
    default:
      std::cout << "Please enter a valid option!\n";
      break;
    }
  }

  return 0;
}
