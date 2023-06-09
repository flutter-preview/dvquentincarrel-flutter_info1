import 'dart:math';
import 'dart:io';

// Les coordonnées d'une case de la grille
class Coordonnees {
  int ligne;
  int colonne;

  Coordonnees(this.ligne, this.colonne);
}

// Une case de la grille
class Case {
  bool minee; // La case comporte-t-elle une mine ?
  bool decouverte = false; // La case a-t-elle été découverte ?
  bool marquee = false; // La case a-t-elle été marquée ?
  int nbMinesAutour = 0; // Nombre de mines autour de la case

  Case(this.minee);
}

// Type d'action qu'un joueur peut réaliser sur une case
enum Action { decouvrir, marquer }

// Coup réalisé par le joueur
class Coup {
  Coordonnees coordonnees;
  Action action;

  Coup(int ligne, int colonne, this.action)
      : coordonnees = Coordonnees(ligne, colonne);
}

// Grille du démineur
class Grille {
  int taille; // dimensions de la grille carrée : taille*taille
  int nbMines; // nombre de mines dans la grille
  List<List<Case>> grille = []; // grille qui comportera taille*taille cases
  // Constructeur
  Grille(this.taille, this.nbMines) {
    int nbCasesACreer =
        taille * taille; // Le nombre de cases qu'il reste à créer
    int nbMinesAPoser = nbMines; // Le nombre de mines qu'il reste à poser
    Random generateur = Random(); // Générateur de nombres aléatoires
    // Pour chaque ligne de la grille
    for (int ligne = 0; ligne < taille; ligne++) {
      // On va ajouter à la grille une nouvelle Ligne (liste de 'cases')
      List<Case> uneLigne = [];
      for (int colonne = 0; colonne < taille; colonne++) {
        // S'il reste nBMinesAPoser dans nbCasesACreer, la probabilité de miner est nbMinesAPoser/nbCasesACreer
        // Donc on tire un nombre aléatoire a dans [1..nbCasesACreer] et on pose une mine si a <= nbMinesAposer
        bool isMinee =
            generateur.nextInt(nbCasesACreer) < nbMinesAPoser;
        if (isMinee) nbMinesAPoser--; // une mine de moins à poser
        uneLigne.add(Case(isMinee)); // On ajoute une nouvelle case à la ligne
        nbCasesACreer--; // Une case de moins à créer
      }
      // On ajoute la nouvelle ligne à la grille
      grille.add(uneLigne);
    }
    // Les cases étant créées et les mines posées, on calcule pour chaque case le 'nombre de mines autour'
    calculeNbMinesAutour();
  }

  // Consulter une case
  Case getCase(Coordonnees coordonnees) {
    return grille[coordonnees.ligne][coordonnees.colonne];
  }

  // Liste des coordonnées des cases voisines d'une case
  List<Coordonnees> getVoisines(Coordonnees coordonnees) {
    List<Coordonnees> listeVoisines = [];
    for(var i = -1; i < 2; i++) { // Ligne
        int newLine = coordonnees.ligne - i;
        bool validLine = (newLine >= 0 && newLine < taille);
        // Only iter over columns if lines are not oob
        for(int j = -1; j < 2 && validLine; j++) { // Colonne
            int newCol = coordonnees.colonne - j;
            bool validCol = (newCol >= 0 && newCol < taille);
            if(validCol) {
                Coordonnees newCoords = Coordonnees(newLine , newCol);
                listeVoisines.add(newCoords);
            }
        }
    }
    return listeVoisines;
  }

  // Calcule pour chaque case le nombre de mines présentes dans ses voisines
  void calculeNbMinesAutour() {
    for(int x = 0; x < taille; x++){
        for(int y = 0; y < taille; y++){
            Case curCase = getCase(Coordonnees(y, x));
            Coordonnees curCoords = Coordonnees(y, x);
            getVoisines(curCoords).forEach((coords) {
                Case neighCase = getCase(coords);
                curCase.nbMinesAutour += neighCase.minee ? 1 : 0;
            });
        }
    }
  }

  // Découvre récursivement toutes les voisines d'une case qui vient d'être découverte
  void decouvrirVoisines(Coordonnees coordonnees) {
      Case curCase = getCase(coordonnees);
      if(!curCase.minee && !curCase.decouverte) {
          curCase.decouverte = true;
          if(curCase.nbMinesAutour <= 0){
          getVoisines(coordonnees).forEach((elem) => decouvrirVoisines(elem));
          }
      } else {
          curCase.decouverte = true;
      }
  }

  // Met à jour la grille en fonction du coup joué
    void mettreAJour(Coup coup) {
        if(isFinie()) {
            print('Game over');
            return;
        }
        Case chosenCase = getCase(coup.coordonnees);
        if(coup.action == Action.decouvrir){
            decouvrirVoisines(coup.coordonnees);
        }
        chosenCase.marquee = coup.action == Action.marquer;
    }

  // Renvoie vrai si la grille a été complètement déminée
  bool isGagnee() {
    for(int x = 0; x < taille; x++) {
        for(int y = 0; y < taille; y++) {
            Case curCase = getCase(Coordonnees(y, x));
            if(curCase.decouverte == curCase.minee) {
                return false;
            }
        }
    }
    print('You won');
    return true;
  }

  // Renvoie vrai si une case minée a été découverte
  bool isPerdue() {
    for(int x = 0; x < taille; x++) {
        for(int y = 0; y < taille; y++) {
            Case curCase = getCase(Coordonnees(y, x));
            if(curCase.decouverte && curCase.minee) {
                print('You lost');
                return true;
            }
        }
    }
    return false;
  }

  // Renvoie vrai si la partie est finie
  bool isFinie() {
    return isGagnee() || isPerdue();
  }
}
