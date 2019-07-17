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
public class WorkDTO {
	private int wno;
	private String title;
	private String content;
	private String writer;
	private int w_like;
	private int viewcnt;
	private String filename; // 첨부파일 이름 배열
	private Date regdate;
}
