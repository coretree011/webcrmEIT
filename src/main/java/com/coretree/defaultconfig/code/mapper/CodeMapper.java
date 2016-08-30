package com.coretree.defaultconfig.code.mapper;

import java.util.List;

import org.springframework.boot.mybatis.autoconfigure.Mapper;

import com.coretree.defaultconfig.code.model.Code;

@Mapper
public interface CodeMapper {
	public List<Code> selectCode(Code code);
	public long deleteExtension(Code code);
	public long insertExtension(Code code);
	public long updateExtension(Code code);
}
