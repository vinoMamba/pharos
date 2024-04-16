/*
Copyright © 2024 Vino <vino0908@outlook.com>
*/
package cmd

import (
	"fmt"
	"os"

	"github.com/spf13/cobra"
	"github.com/vinoMamba/pharos/internal/module"
)

// moduleCmd represents the module command
var moduleCmd = &cobra.Command{
	Use:     "module",
	Example: "vben add module <module-name>",
	Short:   "add a new module to the project",
	Run: func(cmd *cobra.Command, args []string) {
		m := module.NewModule(args)

		if err := m.Create(); err != nil {
			fmt.Println(err)
			os.Exit(1)
		}
		fmt.Println("Module created successfully")
	},
}

func init() {
	addCmd.AddCommand(moduleCmd)
}
