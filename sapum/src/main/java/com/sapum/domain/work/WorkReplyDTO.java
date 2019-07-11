package com.sapum.domain.work;

import java.util.Date;

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
public class WorkReplyDTO {
	private int wrno;
	private String content;
	private String writer;
	private Date regdate;
	private int wno;
 
}
