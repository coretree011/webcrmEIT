package com.coretree.defaultconfig.main.mapper;

import java.util.List;
import java.util.Map;

import org.springframework.boot.mybatis.autoconfigure.Mapper;

import com.coretree.defaultconfig.main.model.Customer;

@Mapper
public interface CustomerMapper {
	public List<Customer> selectCustomerList(Customer customer);
	public List<Customer> selectCustomerListExcel(Customer customer);
	public List<Customer> selectCustomerListGrpSms(Customer customer);
	public long insertCustomer(Customer customer);
	public long insertCustomer2(Customer customer);
	public long updateCustomer(Customer customer);
	public long deleteCustomer(Customer customer);
	public long deleteCustomerOne(Customer customer);
	public Customer selectExistCnt1001(Customer customer);
	public Customer selectExistCnt1002(Customer customer);
	public Customer selectCustomerOne(Customer customer);
	public String selectCustomerCustNo(Customer customer);
	public String selectExitCustomer(Customer customer);
	
	/*송은미 추가*/
	public List<Customer> selectCustomer(Customer customer);
	public String excelData(Map<String, Object> map);
	
	public long insertCustomer3(Map<String, Object> map);
	public long insertCustomer4(Map<String, Object> map);
	public String selectCustomerCustNo2(Map<String, Object> map);

}
