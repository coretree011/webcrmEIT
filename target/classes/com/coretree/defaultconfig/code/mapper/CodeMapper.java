package com.coretree.defaultconfig.code.mapper;

import java.util.List;

import org.springframework.boot.mybatis.autoconfigure.Mapper;

import com.coretree.defaultconfig.code.model.Code;
import com.coretree.defaultconfig.code.model.CodeLarge;

@Mapper
public interface CodeMapper {
	public List<Code> selectCode(Code code);
	public long deleteExtension(Code code);
	public long insertExtension(Code code);
	public long updateExtension(Code code);
	
	//TCODE_LARGE LIST
	public List<CodeLarge> selectCodeLarge(CodeLarge code);
	public List<Code> selectCodeSmall(Code code);
	public Code maxCode(Code code);
	public long codeInsert(Code code); 
	public long codeModify(Code code);
}
