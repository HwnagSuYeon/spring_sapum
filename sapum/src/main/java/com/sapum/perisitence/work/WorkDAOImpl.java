package com.sapum.perisitence.work;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class WorkDAOImpl implements WorkDAO{
	@Inject
	private SqlSession session;

}
