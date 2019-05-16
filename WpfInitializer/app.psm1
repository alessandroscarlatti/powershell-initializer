Add-Type -AssemblyName PresentationFramework
$scriptDir = Split-Path $script:MyInvocation.MyCommand.Path

function runScriptBlock($scriptBlock) {
	try {
		&$scriptBlock
		exit 0
	} catch {
		write-error $_
		Write-Error ($_.InvocationInfo | Format-List -Force | Out-String) -ErrorAction Continue
		exit 1
	}
}

function launchApp {
	$app = AppControl
	$app.showDialog()
}

function AppControl {
[xml]$xaml = @"
<Window
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
	Title="Wpf Initializer"
	SizeToContent="WidthAndHeight"
	ResizeMode="CanMinimize"
	WindowStartupLocation="CenterScreen"
	MaxHeight="600"
	>
	<StackPanel Margin="10">
		<TextBlock 
			Width="300"
			Margin="0,10"
			TextWrapping="Wrap">
			Click this Button.
		</TextBlock>
		<Button Name = "button1">Click This Button</Button>
	</StackPanel>
</Window>
"@

	$control = [Windows.Markup.XamlReader]::Load((New-Object System.Xml.XmlNodeReader $xaml))
	$button1 = $control.FindName("button1")
	
	$button1.Add_Click({
		write-host "button1 clicked"
	})

	return $control
}