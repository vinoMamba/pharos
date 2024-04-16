import type { FormSchema } from '/@/components/Form/type'
import type { TableColumns } from '/@/components/Table/type'

export const schemas: FormSchema[] = [
  {
    field: 'field1',
    label: '字段1',
    component: 'Input',
  },
  {
    field: 'field2',
    label: '字段2',
    component: 'Input',
  },
]

export const columns: TableColumns = [
  {
    title: 'Id',
    dataIndex: 'id',
    width: 100,
    ellipsis: true,
  },
  {
    title: '字段1',
    width: 100,
    dataIndex: 'field',
  },
  {
    title: '字段2',
    width: 100,
    dataIndex: 'field2',
  },
]

export const formSchemas: FormSchema[] = [
  {
    field: 'field1',
    label: '字段1',
    component: 'Input',
    required: true,
  },
  {
    field: 'field2',
    label: '字段2',
    component: 'Input',
    required: true,
  },
]
