# Popover View

## Segue 'present as popover' - 'Use Preferred Explicit Size' on iPhone (a compact horizontal Size Class)

## Segue present Modally 'form Sheet' - 'Use Preferred Explicit Size' on iPad

## Segue present Modally 'form Sheet' - 'Use Preferred Explicit Size' on iPhone (a compact horizontal Size Class)

## Added Pan Gesture on the presented view controller
- Bug: Warning: Attempt to present * on * which is already presenting
- Debugged:
        
        extension ViewController {
            
            func setupGestureRecognizers() {
                gamesTableVC = GamesTableViewController()
                
                let leftPanRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(self.handelLeftEdgePan(gestureRecognizer:)))
                leftPanRecognizer.edges = .left
                
                let rightPanRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(self.handelRightEdgePan(gestuerRecognizer:)))
                rightPanRecognizer.edges = .right
                
                view.addGestureRecognizer(leftPanRecognizer)
                view.addGestureRecognizer(rightPanRecognizer)
            }
            
            @objc func handelLeftEdgePan(gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
            
                //Silenced the Bug Warning as adding the .began state
                if gestureRecognizer.state == .began {
                    performSegue(withIdentifier: "SummerSegue", sender: nil)
                }
            }
            
            @objc func handelRightEdgePan(gestuerRecognizer: UIScreenEdgePanGestureRecognizer) {
            
                //Silenced the Bug Warning as adding the .began state
                if gestuerRecognizer.state == .began {
                    performSegue(withIdentifier: "WinterSegue", sender: nil)
                }
            }
        }

