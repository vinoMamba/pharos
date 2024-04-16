/*
Copyright © 2024 Vino <vino0908@outlook.com>
*/
package cmd

import (
	"os"

	"github.com/spf13/cobra"
)

var rootCmd = &cobra.Command{
	Use:   "pharos",
	Short: "A cli for pharos admin",
	Long: `
 ____  _   _    _    ____   ___  ____  
|  _ \| | | |  / \  |  _ \ / _ \/ ___| 
| |_) | |_| | / _ \ | |_) | | | \___ \ 
|  __/|  _  |/ ___ \|  _ <| |_| |___) |
|_|   |_| |_/_/   \_\_| \_\\___/|____/ 
                                       
` + "A cli for pharos admin",
}

func Execute() {
	err := rootCmd.Execute()
	if err != nil {
		os.Exit(1)
	}
}

func init() {
	rootCmd.Flags().BoolP("toggle", "t", false, "Help message for toggle")
}
