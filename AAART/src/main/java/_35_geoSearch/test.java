package _35_geoSearch;

import java.util.List;

import _35_geoSearch.model.PositionBean;
import _35_geoSearch.service.impl.PositionServiceImpl;

public class test {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		PositionServiceImpl service = new PositionServiceImpl();
		List<PositionBean> list = service.recommendList();
		for (PositionBean item: list) {
			System.out.println(item.getTitle());
			System.out.println(item.getCity());
		}
		
	}

}
