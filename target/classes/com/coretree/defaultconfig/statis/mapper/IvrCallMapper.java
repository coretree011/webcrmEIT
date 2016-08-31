package com.coretree.defaultconfig.statis.mapper;

import java.util.List;

import org.springframework.boot.mybatis.autoconfigure.Mapper;

import com.coretree.defaultconfig.statis.model.IvrCall;

@Mapper
public interface IvrCallMapper {

	public List<IvrCall> selectIvrList(IvrCall ivrCall);
}
