package com.sapum.service.email;

import com.sapum.domain.email.EmailDTO;

public interface EmailService {
	public void sendMail(EmailDTO eDto);
}
