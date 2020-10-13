package _35_geoSearch.service.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.apache.log4j.BasicConfigurator;

import _35_geoSearch.dao.impl.PositionDaoImpl;
import _35_geoSearch.model.MainTableBean;
import _35_geoSearch.model.PositionBean;
import _35_init.util.OpenStreetMapUtils;
import net.sf.geographiclib.*;
//import from Geolib，除了數學公式外，還考慮到地球弧度實際變化來計算經緯度間的距離

public class PositionServiceImpl{
		
		private PositionDaoImpl dao;
		public Geodesic geod = Geodesic.WGS84;
	
		public PositionServiceImpl() {
			this.dao = new PositionDaoImpl();
		}
		
		public List<PositionBean> getPositionBean() {
			return this.dao.readAllToPT();
		}
		
		public List<PositionBean> getNoNullPositionBean() {
			return this.dao.readNoNullToPT();
		}
		
		public double getDistance(double lat1, double lon1, double lat2, double lon2) {
			GeodesicLine line = geod.InverseLine(lat1, lon1, lat2, lon2, GeodesicMask.DISTANCE_IN | GeodesicMask.LATITUDE | GeodesicMask.LONGITUDE);
			double d = line.Distance()/1000; //最後除一千是為了把公尺單位轉換成公里
			return (double)Math.round(d*100)/100; //去除多餘小數點
		}
		
		public List<PositionBean> setDistance (String userLocation) {	
			List<PositionBean> listPT = this.getPositionBean();
			Map<String, Double> coords;
			List<MainTableBean> listMT =this.getNoTitleUnit();
			
			BasicConfigurator.configure();
			OpenStreetMapUtils.log.info("This is Logger Info");
//			上面兩行初始化log4j設定，這個東西拿來記錄get到的地理資訊，沒初始化會出現以下錯誤
			//WARN No appenders could be found for logger
			coords = OpenStreetMapUtils.getInstance().getCoordinates(userLocation);
			double userLat = coords.get("lat");
	        double userLon = coords.get("lon");
			
			double distance = 0;
			for (PositionBean itemPT : listPT) {
				for (MainTableBean itemMT: listMT) {
					if (itemPT.getNo() == itemMT.getNo()) {
						itemPT.setTitle(itemMT.getTitle());
						itemPT.setTime(itemMT.getTime());
					}
				}
				if (itemPT.getLatitude()==0) {
					itemPT.setDistance(0);
				}else {
					distance = this.getDistance(itemPT.getLatitude(), itemPT.getLongitude(), userLat, userLon);
					itemPT.setDistance(distance);
				}
			}
			Collections.sort(listPT);
			//在bean中覆寫了Comparable介面的排序方法
			//設定依照物件中的距離屬性排序
			return listPT;
		}
		
		public List<MainTableBean> getNoTitleUnit() {
			return this.dao.readNoTitleUnitToMT();
		}
		
		public List<PositionBean> recommendList() {	
			//數表格總數
			List<PositionBean> list = this.getNoNullPositionBean();
			int count=0;		
			for (PositionBean itemCount: list) {
				count++;
			}
			
			//取亂數後的隨機三個
			int[] arr=this.produceRandomArray(count);
			List<PositionBean> noNullList = this.getNoNullPositionBean();
			List<PositionBean> recommendList = new ArrayList<PositionBean>();
			for (int i=0;i<3;i++) {
				int timesCount=0;
				for (PositionBean item: noNullList) {
					timesCount++;
					if (timesCount == arr[i]) {
						PositionBean pt = new PositionBean();
						pt.setNo(item.getNo());
						pt.setCity(item.getCity());
						pt.setDistrict(item.getDistrict());
						pt.setVillage(item.getVillage());
						pt.setAddress(item.getAddress());
						recommendList.add(pt);
						break;
					}else {
						continue;
					}
				}
			}
			List<MainTableBean> listMT =this.getNoTitleUnit();
			for (MainTableBean itemMT: listMT) {
				for (PositionBean itemPT: recommendList) {
					if (itemPT.getNo()==itemMT.getNo()) {
						itemPT.setTitle(itemMT.getTitle());
						itemPT.setTime(itemMT.getTime());
					}	
				}
			}
			return recommendList;
		}
		
		public int[] produceRandomArray(int count) {
			
			Random rd = new Random(); // creating Random object
			int[] arr = new int[3];
			for (int i = 0; i < arr.length; i++) {
				arr[i] = rd.nextInt(count)+1; // storing random integers in an array
			    for (int j=0;j<i;j++) {
			    	while (arr[j] == arr[i]) {
			    		j=0;
			    		arr[i] = rd.nextInt(count)+1;
			    	}
			    }
//				System.out.println(arr[i]); // printing each array element
			}
			return arr;
		}
		
}