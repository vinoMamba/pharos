import { httpClient } from '/@/utils/http'

enum Api {
  {{.ApiName}}List = '',
  {{.ApiName}}Save = '',
  {{.ApiName}}Update = '',
  {{.ApiName}}Delete = '',
  {{.ApiName}}Detail = '',
}


export interface {{.ApiName}}ListResult {}

export const get{{.ApiName}}ListApi = () => {
  return httpClient.get<{{.ApiName}}ListResult[]>(
    {
      url: Api.{{.ApiName}}List,
    },
  )
}

export interface Save{{.ApiName}}Params {}
export const save{{.ApiName}}Api = (params: Save{{.ApiName}}Params) => {
  return httpClient.post(
    {
      url: Api.{{.ApiName}}Save,
      data: params,
    },
  )
}

export interface Update{{.ApiName}}Params extends Save{{.ApiName}}Params {
  //Id: string
}
export const update{{.ApiName}}Api = (params: Update{{.ApiName}}Params) => {
  return httpClient.put(
    {
      url: Api.{{.ApiName}}Update,
      data: params,
    },
  )
}

export interface Delete{{.ApiName}}Params {
  //deptIds: Array<string>
}
export const delete{{.ApiName}}Api = (params: Delete{{.ApiName}}Params) => {
  return httpClient.delete(
    {
      url: Api.{{.ApiName}}Delete,
      data: params,
    },
  )
}

export interface {{.ApiName}}DetailResult extends Save{{.ApiName}}Params {
  //roleId: string
}
export interface Get{{.ApiName}}DetailParams {}
export const get{{.ApiName}}DetailApi = (params: Get{{.ApiName}}DetailParams) => {
  return httpClient.get<{{.ApiName}}DetailResult>(
    {
      url: Api.{{.ApiName}}Detail,
      params,
    },
  )
}
