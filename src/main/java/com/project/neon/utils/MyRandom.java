package com.project.neon.utils;

public class MyRandom {
	public static Integer getIntRandom(Integer max, int min){
		return (int)(Math.random() * (max - min) + min);
	}
}
