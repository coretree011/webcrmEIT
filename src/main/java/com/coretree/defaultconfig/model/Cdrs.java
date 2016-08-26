package com.coretree.defaultconfig.model;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import com.coretree.defaultconfig.mapper.Cdr;
import com.coretree.sql.DBConnection;
import com.coretree.util.Finalvars;
import com.coretree.util.Util;

public class Cdrs {
	private List<Cdr> lists;
	
	public Cdrs(Date sdate, Date edate, String username) {
		try {
			String sql = "{call GET_CDR_LIST_BY_DATE2(?, ?, ?)}";
			
			try(Connection con = DBConnection.getConnection();
					CallableStatement stmt = con.prepareCall(sql)) {
				
				stmt.setDate(1, sdate);
				stmt.setDate(2, edate);
				stmt.setString(3, username);
				
				ResultSet rs = stmt.executeQuery();
				
				while (rs.next()) {
					Cdr cdr = new Cdr();
					cdr.setIdx(rs.getLong(0));
					cdr.setTotalsecs(rs.getInt(1));
					
					this.lists.add(cdr);
			    }
			} catch (SQLException ex) {
				ex.printStackTrace();
			} finally {
				System.out.println(String.format("sql: %s", sql));
			}
		} catch (NullPointerException | UnsupportedOperationException e) {
			Util.WriteLog(String.format(Finalvars.ErrHeader, 1002, e.getMessage()), 1);
		}
	}
	
	public List<Cdr> Get() {
		return lists;
	}
}
