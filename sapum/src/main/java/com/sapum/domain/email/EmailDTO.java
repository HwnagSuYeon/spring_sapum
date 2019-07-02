package com.sapum.domain.email;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class EmailDTO {
	private String senderName;		// 발신자 이름
	private String senderMail;		// 수신자 이메일 주소
	private String receiveMail;		// 수신자 이메일 주소
	private String subject;			// 제목
	private String message;			// 본문
}
