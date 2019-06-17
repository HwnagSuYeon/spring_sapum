package com.sapum.service.member;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.sapum.perisitence.member.MemberDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MemberServiceImpl implements MemberService{
	@Inject MemberDAO mDao;
}
