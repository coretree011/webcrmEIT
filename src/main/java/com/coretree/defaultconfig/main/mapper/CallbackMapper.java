package com.coretree.defaultconfig.main.mapper;

import java.util.List;

import org.springframework.boot.mybatis.autoconfigure.Mapper;

import com.coretree.defaultconfig.main.model.Callback;

@Mapper
public interface CallbackMapper {
	public List<Callback> callbackList(Callback callback);
	public long updateCallback(Callback callback);
	public List<Callback> reservationList(Callback callback);
	public long insertReservation(Callback callback);
	public long updateReservation(Callback callback);
	public void insTCallback(Callback callback);
	public void delTCallback(int cdseq);
}
