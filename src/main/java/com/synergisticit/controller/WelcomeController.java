package com.synergisticit.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

//THis is an API for dynamic resource
//REstController will capture the API 
@RestController
public class WelcomeController {
	
	@GetMapping("/welcome")
	public String welcome() {
		return " welcome to Spring boot world";
	}
	
	@GetMapping("/hello")
	public String hello() {
		return "Welcome to Hello World";
	}
}
