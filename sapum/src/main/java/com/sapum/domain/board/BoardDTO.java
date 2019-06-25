package com.sapum.domain.board;

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
public class BoardDTO {
	private int bno;
	private String title;
	private String content;
	private String writer;
	private int viewcnt;
	private int replycnt;
	private Date regdate;
}
