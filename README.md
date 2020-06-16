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

## Improved pan gesture dissmissing form sheet view through tracking pan translation value of coordinate.Y
        
        extension iPhoneFormSheetViewController {
            func setupGestureRecognizers() {
                let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.handlePan(gestureRecognizer:)))
                view.addGestureRecognizer(panRecognizer)
            }
            
            @objc func handlePan(gestureRecognizer: UIPanGestureRecognizer) {
                
                let view = gestureRecognizer.view!
                
                switch gestureRecognizer.state {
                case .began, .changed:
                    moveViewWithPan(view: view, sender: gestureRecognizer)
                case .ended:
                    deleteView(view: view)
                default:
                    break
                }
                
            }
            
            func moveViewWithPan(view: UIView, sender: UIPanGestureRecognizer) {
                
                let translation = sender.translation(in: view)
                
                /// Tracking target view's routing corresponding to the pan gesture translation in the coordinate system of the specified view.
                view.center = CGPoint(x: view.center.x, y: view.center.y+translation.y)
                
                /// Resetting translation value to zero after pan gesture finished.
                sender.setTranslation(CGPoint.zero, in: view)

            }

            func deleteView(view: UIView) {
                UIView.animate(withDuration: 0.3) {
                    self.dismiss(animated: true, completion: nil)
                }
            }

        }

