package com.coretree.defaultconfig.main.mapper;

import java.util.List;
import org.springframework.boot.mybatis.autoconfigure.Mapper;
import com.coretree.defaultconfig.main.model.Ivr;

@Mapper
public interface IvrMapper {
	public List<Ivr> selectIvr(Ivr param);
	public void insertIvr(Ivr param);
	public void delIvr(long cb_seq);
}
