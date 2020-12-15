const baseUrl = 'http://192.168.31.194:8080/';
const servicePath = {
  'homePageContent': baseUrl + "homePageContent", // 首页数据 -> 获取饮品分类
  'getCategory': baseUrl + "getAllCategory", // 甜品、奶茶分类信息
  'getMilkyTea': baseUrl + "getMilkyTea", // 获取所有奶茶
  'getAttribute': baseUrl + "getAllAttribute", // 获取所有属性
  'getMilkyTeaByCid': baseUrl + "getMilkyTeaByCategory/", // 通过分类ID获取奶茶
  'login': baseUrl + 'user/login'
};
