package com.smdm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.smdm.bean.Orders;
import com.smdm.bean.OrdersExample;
import com.smdm.bean.OrdersExample.Criteria;
import com.smdm.dao.OrdersMapper;

/**
 * 用户订单相关服务
 * @author manRED
 *
 */
@Service	
public class OrdersService {
	
	@Autowired
	OrdersMapper ordersMapper;
	
	/**
	 * 查询用户订单列表
	 * @param userId
	 * @return
	 */
	public List<Orders>	getOrderList(int userId){
		OrdersExample example=new OrdersExample();
		Criteria criteria=example.createCriteria();
		criteria.andUserIdEqualTo(userId);
		return ordersMapper.selectByExample(example);	
	}
	
	/**
	 * 删除用户order
	 * @param orderId
	 * @return
	 */
	public boolean deleteOrder(int orderId) {
		int result=ordersMapper.deleteByPrimaryKey(orderId);
		if(result>0) {
			return true;
		}
		return false;
	}
	
	/**
	 * 插入order
	 * @param order
	 */
	public void insertOrder(Orders order) {
		ordersMapper.insert(order);
	}
}
