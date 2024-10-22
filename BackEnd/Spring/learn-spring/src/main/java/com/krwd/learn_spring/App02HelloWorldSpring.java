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
		String name = (String) context.getBean("name");
		System.out.println(name);
		
//		int age = (int) context.getBean("age");
		int age = (int) context.getBean("age2");
		System.out.println(age);
		
		Person person = (Person) context.getBean("person");
		System.out.println(person);
		
		Person person2MethodCall = (Person) context.getBean("person2MethodCall");
		System.out.println(person2MethodCall);
		
		Person person3Parameters = (Person) context.getBean("person3Parameters");
		System.out.println(person3Parameters);
		
		Address address = (Address) context.getBean("address2");
		System.out.println(address);
		
		// Address.class 라는 타입의 빈을 얻고 싶을 때
//		Address address2 = context.getBean(Address.class);
//		System.out.println(address2);
	}
}
