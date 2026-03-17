import axios from 'axios'

// 创建 axios 实例
const request = axios.create({
  // API 请求的默认前缀
  baseURL: "https://api.trongrid.io",
  // baseURL: "https://blockchain.info",
  timeout: 60000, // 请求超时时间
  headers: {'TRON-PRO-API-KEY': "79bca3d7-3c52-4838-b689-a638fe9b9dfa" },
  // headers: { 'Access-Control-Allow-Origin': '*' }
})

// 异常拦截处理器
const errorHandler = (error) => {
  if (error.response) {
    const data = error.response.data
    // 从 localstorage 获取 token
    if (error.response.status === 403) {
      // notification.error({
      //   message: '被禁止',
      //   description: data.message
      // })
    }
    if (error.response.status === 404) {
      // notification.error({
      //   message: '接口未找到',
      //   description: `${data.path}`
      // })
    }
    if (error.response.status === 403 && !(data.result && data.result.isLogin)) {
      // notification.error({
      //   message: '认证失效',
      //   description: '用户认证失败'
      // })
    }
    if (error.response.status >= 500) {
      // notification.error({
      //   message: '服务器错误',
      //   description: data.message || error.response.statusText
      // })
    }
  }

  return Promise.reject(error)
}
// request interceptor
request.interceptors.request.use((config) => {
  config.headers.session = '000001'
  return config
})

// response interceptor
request.interceptors.response.use((response) => {
  return response.data

}, errorHandler)
// 


export default request

export { request as axios }
