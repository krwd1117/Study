package com.krwd.learn_spring;


import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import com.krwd.learn_spring.game.GameRunner;
import com.krwd.learn_spring.game.PacmanGame;

public class App02HelloWorldSpring {
	
	public static void main(String[] args) {
		
		// 1. Launch a Spring Context
		var context = new AnnotationConfigApplicationContext(HelloWorldConfiguration.class);
		
		// 2. Configure the things that we want Spring to manage - 
		// HelloWorldConfiguration - @Configuration
		// name - @Bean
		
		// 3. Retrieving Beans managed by Spring
		System.out.println(context.getBean("name"));
	}
}