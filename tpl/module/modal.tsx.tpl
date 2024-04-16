import { defineComponent, ref } from 'vue'
import type { RegisterFn } from '/@/components/Modal/type'
import { formSchemas } from './schema'
import { useMessage } from '/@/hooks/useMessage'
import { PharosForm } from '/@/components/Form'
import { useForm } from '/@/components/Form/useForm'
import { useModal } from '/@/components/Modal/useModal'
import { PharosModal } from '/@/components/Modal'

export const {{.ModuleName}}Modal = defineComponent<{ onRegister: RegisterFn, onSuccess: () => void }>({
  name: '{{.ModuleName}}Modal',
  emits: ['success'],
  setup(_, { emit }) {
    const isUpdate = ref(false)
    const { message } = useMessage()
    const [registerForm, { validate, resetFields, setFieldsValue }] = useForm({
      schemas: formSchemas,
      labelCol: {
        span: 5,
      },
      colProps: {
        span: 24,
      },
    })

    const [register, { setModalProps, closeModal }] = useModal(async (data) => {
      resetFields()
      isUpdate.value = data.isUpdate
      if (data.isUpdate) {
        // update the form fields with the data from the API
        setFieldsValue([])
      }
    })

    const handleOk = async () => {
      try {
        setModalProps({ confirmLoading: true })
        const values = await validate()
        if (values) {
          // await roleSaveApi(values as RoleSaveParams)
          closeModal()
          message.success('新增成功')
          emit('success')
        }
      }
      finally {
        setModalProps({ confirmLoading: false })
      }
    }

    const handleCancel = () => {
      closeModal()
    }

    return () => (
      <PharosModal
        onRegister={register}
        onOk={handleOk}
        onCancel={handleCancel}
      >
        {{"{{"}}default: () => (<PharosForm onRegister={registerForm} />){{"}}"}}
      </PharosModal>
    )
  },
})
