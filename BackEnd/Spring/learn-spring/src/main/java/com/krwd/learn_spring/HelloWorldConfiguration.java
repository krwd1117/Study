package com.krwd.learn_spring;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;

record Person(String name, int age, Address address) {};
record Address(String firstLine, String city) {};

@Configuration
public class HelloWorldConfiguration {
	
	// Bean의 기본 값은 메소드의 이름을 따라감
	@Bean
	public String name() {
		return "Ranga";
	}
	
	// Bean의 이름을 할당할 수 있음
	@Bean(name = "age2")
	public int age() {
		return 30;
	}
	
	
	@Bean
	public Person person() {
		var person = new Person("Ravi", 2, new Address("Main Street", "Utrecht"));
		return person;
	}
	
	// 기존의 빈을 사용하여 새로운 빈을 생성
	@Bean
	public Person person2MethodCall() {
		var person = new Person(name(), age(), address());
		return person;
	}
	
	@Bean
	public Person person3Parameters(String name, int age, Address address3) { // name, age, address2
		var person = new Person(name, age, address3);
		return person;
	}
	
	@Bean
	@Primary
	public Person person4Parameters(String name, int age, Address address) { // name, age, address2
		var person = new Person(name, age, address);
		return person;
	}
	
	@Bean
	public Person person5Qulifier(
				String name, 
				int age, 
				@Qualifier("address3qualifier") Address address
			) {
		var person = new Person(name, age, address);
		return person;
	}
	
	@Bean(name = "address2")
	@Primary
	public Address address() {
		var address = new Address("Baker Street", "London");
		return address;
	}
	
	@Bean(name = "address3")
	@Qualifier("address3qualifier")
	public Address address3() {
		var address = new Address("Motinagar", "Hyderabad");
		return address;
	}
}
