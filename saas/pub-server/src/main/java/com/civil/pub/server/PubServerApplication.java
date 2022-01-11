package com.civil.pub.server;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
//@BootstrapConfiguration
//@EnableDiscoveryClient
public class PubServerApplication {

	public static void main(String[] args) {
		SpringApplication.run(PubServerApplication.class, args);
	}

}
