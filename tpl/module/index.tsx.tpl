import { defineComponent } from 'vue'
import { PharosPage } from '/@/components/Page'
import { PharosTable } from '/@/components/Table'
import { useTable } from '/@/components/Table/useTable'
import { Button } from 'ant-design-vue'
import { useMessage } from '/@/hooks/useMessage'
import { columns, schemas } from './schema'
import { {{.ModuleName}}Modal } from './{{.ModuleName}}Modal'
import { useModalOutside } from '/@/components/Modal/useModal'

export default defineComponent({
  name: '{{.ModuleName}}',
  setup() {
    const { modal, message } = useMessage()
    const [registerTable, { reload }] = useTable({
      // api: rolesApi,
      rowKey: 'roleId',
      tableTitle: '{{.ModuleName}}标题',
      columns,
      showIndexColumn: true,
      actionColumn: {
        title: '操作',
        width: 100,
        customRender: ({ record }) => {
          return (
            <>
              <Button type="link" onClick={() => handleEdit(record)}>编辑</Button>
              <Button type="link" danger onClick={() => handleDelete(record)}>删除</Button>
            </>
          )
        },
      },
      showSearchForm: true,
      formConfig: {
        showActionButtonGroup: true,
        schemas,
        colProps: {
          span: 8,
        },
      },
    })

    const [registerModal, { openModal }] = useModalOutside()

    const handleDelete = async (record: Recordable) => {
      modal.confirm({
        content: '是否确认删除？',
        okText: '确认',
        cancelText: '取消',
        onOk: async () => {
          try {
            // await roleDeleteApi({ roleIds: [record.roleId] })
            message.success('删除成功')
            reload()
          }
          catch (error) {
            message.error(error as unknown as string)
          }
        },
      })
    }

    const handleAdd = () => {
      openModal({
        isUpdate: false,
      }, {
        title: '新增',
      })
    }

    const handleEdit = (record: Recordable) => {
      openModal({
        isUpdate: true,
        roleId: record.roleId,
      }, {
        title: '编辑',
      })
    }
    return () => (
      <PharosPage>
        <PharosTable onRegister={registerTable}>
          {{"{{"}}
            toolbar: () => (<Button type="primary" onClick={handleAdd}>新增角色</Button>),
          {{"}}"}}
        </PharosTable>
        <{{.ModuleName}}Modal onRegister={registerModal} onSuccess={() => reload()} />
      </PharosPage>
    )
  },
})
