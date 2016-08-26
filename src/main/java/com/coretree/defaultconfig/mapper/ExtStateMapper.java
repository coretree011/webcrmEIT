package com.coretree.defaultconfig.mapper;

import java.util.List;

import org.springframework.boot.mybatis.autoconfigure.Mapper;

@Mapper
public interface ExtStateMapper {
	List<Extension> getAll();
}
