//
//  Calculator.swift
//  RampBuilder
//
//  Created by Madsbook on 23.01.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import SwiftUI
import Combine

enum GapCalculator {
    
    static func calcTakeoffRadius(height: Double, angle: Double) -> Double {
        if angle == 0 { return 0 }
        return round(height / (2 * (sin(angle.toRadians() / 2) * sin(angle.toRadians() / 2))) * 100) / 100;
    }
    
    static func calcTakeoffLength(height: Double, angle: Double) -> Double {
        if angle == 0 { return 1 }
        return (height * (1/sin(angle.toRadians()) + 1/tan(angle.toRadians())))
    }
    
    static func calcLandingLength(height: Double, angle: Double) -> Double {
        if angle == 0 { return 1 }
        return height * tan((90 - angle).toRadians())
    }
    
    // TODO
    static func calcStiffness(speed: Double, gap: Double, angleTakeoff: Double, angleLanding: Double, heightLanding: Double, heightTakeoff: Double) ->  Double {
         let v0 = speed * 1000 / 3600
         let v0x = v0 * cos(angleTakeoff.toRadians())
         let v0y = v0 * sin(angleTakeoff.toRadians())
//         let L = pow(v0,2) * sin(angleTakeoff.toRadians() * 2) / 9.8
//         let H = pow(v0,2) * pow(sin(angleTakeoff.toRadians()), 2) / (2 * 9.8)
         
         
         let dp = abs(heightLanding / tan(angleLanding.toRadians()))
         
         let a = -9.8 / (2 * pow(v0x, 2))
         let b = v0y / v0x + heightLanding / dp
         let c1 = heightLanding * gap / dp
         let c2 = heightLanding + c1
         
         let c = -c2 + heightTakeoff
         
         let diskr = b * b - 4 * a * c
         
//         print("v0 = \(v0), v0x = \(v0x), L = \(L), H = \(H), a = \(a), b = \(b), c = \(c), diskr = \(diskr)")
         
         if (diskr<0) {
             print("Нет пересечения траектории с приземлением! \(diskr)")
             return 0
         } else {
             
             // root of the quadratic equation
             let xroot = (-b - sqrt(diskr))/(2*a)
             let vk = sqrt(v0x*v0x + pow((v0y - 9.8 * xroot / v0x),2))
             let fi = atan((v0y - 9.8 * xroot / v0x) / v0x)
             
//             print("xroot \(xroot), vk = \(vk), fi = \(fi)")
             
             // landing stiffness
             let stiffness = pow(vk * sin(abs(abs(fi) - angleLanding.toRadians())), 2) / (2 * 9.8)
                         
             return stiffness
         }
     }
    
    static func calcMaxHeight(speed: Double, takeoffAngle: Double, takeoffHeight: Double) -> Double {
        return pow(speed * 0.28, 2) * pow(sin(takeoffAngle.toRadians()), 2) / (2 * 9.82)
    }

/*
    Private Sub CommandButton1_Click()
    ActiveSheet.Unprotect (777)
    On Error GoTo err_msg

    L = Range("C4").Value 'гэп
    L1 = Range("C5").Value 'стол
    H = Range("C6").Value 'высота вылета
    H1 = Range("C7").Value 'высота приземления
    A = Range("C8").Value 'угол вылета
    A1 = Range("C9").Value 'угол приземления
    V = Range("C10").Value 'скорость

    If L = "" Then
    L = 0
    L1 = 0
    Range("C4") = L
    Range("C5") = L1
    End If

    If L1 = "" Then L1 = 0: Range("C5") = L1
    If H = "" Then H = 0: Range("C6") = H
    If H1 = "" Then H1 = 0: Range("C7") = H1
    If A = "" Then A = 0: Range("C8") = A
    If A1 = "" Then A1 = 0: Range("C9") = A1
    If V = "" Or V = 0 Then MsgBox ("прыжок на месте"): Range("C16:C23") = "": End

    If hight(H, L - L1, A, V) < H1 Then
    Range("C16:C23") = "НЕДОЛЕТ"
    End
    End If

    If L1 > 0 And hight(H, L, A, V) < H1 Then
    bx = Tan(A * 3.14159265358979 / 180)
    cx = H - H1
    B1 = dist(-9.82 / (2 * (V * 0.28) ^ 2 * Cos(A * 3.14159265358979 / 180) ^ 2), bx, cx)
    H2 = H1
    Ag = 0
    Else
    bx = Tan(A * 3.14159265358979 / 180) + Tan(A1 * 3.14159265358979 / 180)
    cx = H - H1 - L * Tan(A1 * 3.14159265358979 / 180)
    B1 = dist(-9.82 / (2 * (V * 0.28) ^ 2 * (Cos(A * 3.14159265358979 / 180)) ^ 2), bx, cx)
    H2 = H1 - (B1 - L) * Tan(A1 * 3.14159265358979 / 180)
    Ag = A1
    End If

    V2 = Sqr((V * 0.28) ^ 2 + 2 * 9.82 * (H - H2)) / 0.28
    X1 = Sqr((V * 0.28) ^ 2 * Sin(A * 3.14159265358979 / 180) ^ 2 + 2 * 9.82 * (H - H2)) / (V2 * 0.28)
    A2 = Atn(X1 / Sqr(-X1 * X1 + 1)) * 180 / 3.14159265358979
    HMAX = (V * 0.28) ^ 2 * (Sin(A * 3.14159265358979 / 180)) ^ 2 / (2 * 9.82) + H
    G = 0.316 * V2 * Sin((A2 - Ag) * 3.14159265358979 / 180)
    Vv = V2 * Cos((A2 - Ag) * 3.14159265358979 / 180)

    If A <= 0 Then
    VRaz = V
    Else
    VRaz = Sqr((V * 0.28) ^ 2 + 2 * 9.82 * H) / 0.28
    End If

    Range("C16") = B1 'общий пролет
    Range("C17") = H2 'высота точки приземления
    Range("C19") = V2 'скорость приземлени
    Range("C22") = A2 'угол падения
    Range("C18") = HMAX 'максимальная высота
    Range("C21") = VRaz 'необходимая скорость разгона
    Range("C23") = G 'жесткость приземления (G=5 - эквивалентно приземлению на плоскач с дропа высотой 1 м)
    Range("C20") = Vv 'скорость выката

    ActiveSheet.Protect (777)
    ActiveSheet.EnableSelection = xlUnlockedCells

    End

    err_msg:
    MsgBox "Ошибка при рассчетах"
    ActiveSheet.Protect (777)
    ActiveSheet.EnableSelection = xlUnlockedCells
    End Sub
    Private Sub Worksheet_SelectionChange(ByVal Target As Range)
    On Error GoTo err_
    Set isect = Application.Intersect(Target, Range("C4:C10"))
    If Not isect Is Nothing Then
    ActiveSheet.Unprotect (777)
    Range(Cells(13, 3), Cells(23, 3)).Value = ""
    ActiveSheet.Protect (777)
    End If
    err_:
    End Sub
    Function hight(Hf, X, af, Vf)
    hight = Hf + X * Tan(af * 3.14159265358979 / 180) - 9.82 * X ^ 2 / (2 * (Vf * 0.28) ^ 2 * Cos(af * 3.14159265358979 / 180) ^ 2)
    End Function
    Function dist(af, bf, cf)
    dist = (-bf - Sqr(bf ^ 2 - 4 * af * cf)) / (2 * af)
    End Function
 */
}
