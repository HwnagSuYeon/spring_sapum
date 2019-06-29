package com.sapum.service.work;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.sapum.perisitence.work.WorkDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class WorkServiceImpl implements WorkService{
	@Inject
	private WorkDAO wDao;
}
