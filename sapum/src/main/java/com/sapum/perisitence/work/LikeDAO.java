package com.sapum.perisitence.work;

public interface LikeDAO {
	public int check_like(int wno, String id);

	public void insertLike(int wno, String id);

	public void deleteLike(int wno, String id);
}
