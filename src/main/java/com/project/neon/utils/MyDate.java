package com.project.neon.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class MyDate {
	private static SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
	public static Calendar string2Calendar(String input){
		Date date = null; 
        try {
			date = (Date)dateFormat.parse(input);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
        if(date == null)
        	return null;
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        return calendar;
	}
	
	public static String calendar2String(Calendar calendar){
		String str = dateFormat.format(calendar.getTime());
		return str;
	}
	
	public static String calendar2String(Calendar calendar, String format){
		SimpleDateFormat privateDateFormat = new SimpleDateFormat(format);
		String str = privateDateFormat.format(calendar.getTime());
		return str;
	}
}
