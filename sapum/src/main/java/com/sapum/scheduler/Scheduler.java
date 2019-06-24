package com.sapum.scheduler;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class Scheduler {
	
	@Scheduled(cron = "0 42 13 * * *")
	public void cronTest() {
		log.info("Welcome batch job111");
		log.info("Welcome batch job222");
		log.info("Welcome batch job333");
		log.info("Welcome batch job444");
		log.info("Welcome batch job555");
	}
}
