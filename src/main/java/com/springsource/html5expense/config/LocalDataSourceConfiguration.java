package com.springsource.html5expense.config;

import javax.sql.DataSource;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.context.annotation.PropertySource;
import org.springframework.jdbc.datasource.SimpleDriverDataSource;

@Configuration
@Profile("local")
@PropertySource("/db.properties")
public class LocalDataSourceConfiguration implements DataSourceConfiguration {
	
	@Value("${postgres.username}")
	private String userName;
	
	@Value("${postgres.password}")
	private String password;
	
	@Value("${postgres.host}")
	private String hostName;
	
	@Value("${postgres.port}")
	private String portNo;
	
	@Value("${postgres.db.name}")
	private String dbName;

    @Bean
    public DataSource dataSource() {
        SimpleDriverDataSource dataSource = new SimpleDriverDataSource();
        dataSource.setUrl(String.format("jdbc:postgresql://%s:%s/%s", hostName, portNo, dbName));
        dataSource.setDriverClass(org.postgresql.Driver.class);
        dataSource.setUsername(userName);
        dataSource.setPassword(password);
        return dataSource;
    }
}
