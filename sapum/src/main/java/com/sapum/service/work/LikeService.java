package com.sapum.service.work;

import javax.servlet.http.HttpSession;

public interface LikeService {
	public int check_like(int wno, HttpSession session);

	public void switch_like(int wno, HttpSession session);
}
