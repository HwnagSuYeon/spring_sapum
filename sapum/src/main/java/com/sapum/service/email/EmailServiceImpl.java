package com.sapum.service.email;

import javax.inject.Inject;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.sapum.domain.email.EmailDTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class EmailServiceImpl implements EmailService{
	@Inject
	JavaMailSender mailSender; // root-context.xml에 설정한 bean
	
	@Override
	public void sendMail(EmailDTO eDto) {
		try {
			// 이메일 객체
			MimeMessage msg = mailSender.createMimeMessage();
			// 받는사람
			msg.addRecipient(RecipientType.TO, new InternetAddress(eDto.getReceiveMail()));
			// 보내는 사람(이메일주소+이름)
			msg.addFrom(new InternetAddress[] {new InternetAddress(eDto.getReceiveMail(), eDto.getSenderName())});
			// 이메일 제목
			msg.setSubject(eDto.getSubject(), "utf-8");
			// 이메일 본문
			msg.setText(eDto.getMessage(), "utf-8");
			
			// 이메일 발송
			mailSender.send(msg);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}
