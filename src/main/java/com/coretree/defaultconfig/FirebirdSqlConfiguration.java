package com.coretree.defaultconfig;

import org.firebirdsql.pool.FBWrappingDataSource;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;

import java.sql.SQLException;

import javax.sql.DataSource;
import javax.validation.constraints.NotNull;

/**
 * firebird db설정을 위한 클래스
 * @author hsw
 *
 */
@Configuration
@Component
@EnableConfigurationProperties
@ConfigurationProperties(locations = "classpath:/jdbc.properties", prefix = "fbdb")
public class FirebirdSqlConfiguration {
	@NotNull
    private String database;
	@NotNull
    private String username;
    @NotNull
    private String password;
    private int connecttimeout;
    private String charset;
    private String sqldialect;
    private boolean pooling;
    private int socketbuffersize;
    private String type;
    
    public void setUsername(String username) {
        this.username = username;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    public void setDatabase(String database) {
        this.database = database;
    }
    public void setConnecttimeout(int connecttimeout) {
        this.connecttimeout = connecttimeout;
    }
    public void setCharset(String charset) {
        this.charset = charset;
    }
    public void setSqldialect(String sqldialect) {
        this.sqldialect = sqldialect;
    }
    public void setPooling(boolean pooling) {
        this.pooling = pooling;
    }
    public void setSocketbuffersize(int socketbuffersize) {
        this.socketbuffersize = socketbuffersize;
    }
    public void setType(String type) {
    	this.type = type;
    }
    
    @Bean
    DataSource dataSource() throws SQLException {
    	FBWrappingDataSource dataSource = new FBWrappingDataSource();
    	
    	dataSource.setDatabase(database);
    	dataSource.setUserName(username);
    	dataSource.setPassword(password);
    	dataSource.setConnectTimeout(connecttimeout);
    	dataSource.setCharSet(charset);
    	dataSource.setSqlDialect(sqldialect);
    	dataSource.setPooling(pooling);
    	dataSource.setSocketBufferSize(socketbuffersize);
    	dataSource.setType(type);

        return dataSource;
    }
}
