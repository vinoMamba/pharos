/*
Copyright © 2024 Vino <vino0908@outlook.com>
*/
package cmd

import (
	"fmt"
	"os"

	"github.com/spf13/cobra"
	"github.com/vinoMamba/pharos/internal/api"
)

var apiCmd = &cobra.Command{
	Use:     "api",
	Example: "pharos add api <interface-name>",
	Short:   "Add a new api file",
	Run: func(cmd *cobra.Command, args []string) {
		a := api.NewApi(args)
		if err := a.Create(); err != nil {
			fmt.Println(err)
			os.Exit(1)
		}
		fmt.Println("api file created successfully")
	},
}

func init() {
	addCmd.AddCommand(apiCmd)
}
