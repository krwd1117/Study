package com.krwd.learn_spring;

import com.krwd.learn_spring.game.GameRunner;
import com.krwd.learn_spring.game.PacmanGame;

public class App01GamingBasicJava {
	
	public static void main(String[] args) {
		
		//var game = new MarioGame();
		//var game = new SuperContraGame();
		
		var game = new PacmanGame(); //1: Object Creation
		
		var gameRunner = new GameRunner(game); 
			//2: Object Creation + Wiring of Dependencies
			// Game is a Dependency of GameRunner
		
		gameRunner.run();

	}

}
