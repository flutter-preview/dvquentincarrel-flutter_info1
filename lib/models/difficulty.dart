enum Level {debug, easy, medium, hard}

class Difficulty {
  int taille = 0;
  int nbMines = 0;
  Level level = Level.easy;

  Difficulty(Level level) {
    switch(level){
      case Level.debug:
        taille = 10;
        nbMines = 1;
      break;
      case Level.easy:
        taille = 8;
        nbMines = 6;
      break;
      case Level.medium:
        taille = 15;
        nbMines = 45;
      break;
      case Level.hard:
        taille = 35;
        nbMines = 300;
      break;
    }
    level=level;
  }
}
