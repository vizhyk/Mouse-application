
# import the necessary packages
import imutils
from scipy.spatial import distance as dist
from imutils.video import FileVideoStream
from imutils.video import VideoStream
from imutils import face_utils
import numpy as np
import argparse
import time
import dlib
import cv2
import mouse
import pathlib
from threading import Thread

# define two constants, one for the eye aspect ratio to indicate
# blink and then a second constant for the number of consecutive
# frames the eye must be below the threshold

EYE_AR_THRESH = 0.4  #value just for blinks
EYE_LEFT_AR_THRESH = 0.25 #value for left eye blinks
EYE_RIGHT_AR_THRESH = 0.25 #value for right eye blinks
EYE_AR_THRESH_LEFT_CLICK = 0.5
EYE_AR_THRESH_RIGHT_CLICK = 0.5

EAR = 1.0

EYE_LEFT_BELOW_AR_THRESH = 0.2
EYE_RIGHT_BELOW_AR_THRESH = 0.2

EYE_AR_CONSEC_FRAMES = 2
# initialize the frame counters and the total number of blinks
COUNTER = 0
DOUBLE_CLICK_LEFT_COUNTER = 0
DOUBLE_CLICK_RIGHT_COUNTER = 0

TOTAL = 0
TOTAL_DOUBLE_CLICK_LEFT = 0
TOTAL_DOUBLE_CLICK_RIGHT = 0

LEFT_EYE_BLINK_COUNTER = 0
LEFT_TOTAL = 0

RIGHT_EYE_BLINK_COUNTER = 0
RIGHT_TOTAL = 0

LEFT_EYE_SETTING = 0
RIGHT_EYE_SETTING = 1

DOUBLE_CLICK_TIMER = 3.0

def eye_aspect_ratio(eye):
	# compute the euclidean distances between the two sets of
	# vertical eye landmarks (x, y)-coordinates
	A = dist.euclidean(eye[1], eye[5])
	B = dist.euclidean(eye[2], eye[4])
	# compute the euclidean distance between the horizontal
	# eye landmark (x, y)-coordinates
	C = dist.euclidean(eye[0], eye[3])
	# compute the eye aspect ratio
	ear = (A + B) / (2.0 * C)
	# return the eye aspect ratio
	return ear

def left_eye_double_click():
    global EAR
    global DOUBLE_CLICK_LEFT_COUNTER
    global TOTAL_DOUBLE_CLICK_LEFT
    timing = time.time()
    
    while True:
        if EAR < EYE_AR_THRESH_LEFT_CLICK:
            DOUBLE_CLICK_LEFT_COUNTER += 1
		# otherwise, the eye aspect ratio is not below the blink
		# threshold
        else:
			# if the eyes were closed for a sufficient number of
			# then increment the total number of blinks
            if DOUBLE_CLICK_LEFT_COUNTER >= EYE_AR_CONSEC_FRAMES:
                 TOTAL_DOUBLE_CLICK_LEFT += 1
			# reset the eye frame counter
                 DOUBLE_CLICK_LEFT_COUNTER = 0
        if time.time() - timing > DOUBLE_CLICK_TIMER:
           timing = time.time()
           #print(EAR)
           #print(TOTAL_DOUBLE_CLICK_LEFT)
        if TOTAL_DOUBLE_CLICK_LEFT >= 2:
           mouse.click('left')
           TOTAL_DOUBLE_CLICK_LEFT = 0

def close_eyes_left_click():
    global EAR
    global EYE_AR_THRESH
    global TOTAL
    global COUNTER
    #timing = time.time()

    while True:
        if EAR < EYE_AR_THRESH:
            COUNTER += 1
		# otherwise, the eye aspect ratio is not below the blink
		# threshold
        else:
			# if the eyes were closed for a sufficient number of
			# then increment the total number of blinks
			# EYE_AR_CONSEC_FRAMES
            if COUNTER >= EYE_AR_CONSEC_FRAMES:               
                TOTAL += 1
			# reset the eye frame counter
                COUNTER = 0
        #if time.time() - timing > DOUBLE_CLICK_TIMER:
           #timing = time.time()
           #print(EAR)
           #print(TOTAL_DOUBLE_CLICK_LEFT)
        if TOTAL >= 1:
           mouse.click('left')
           TOTAL = 0 

def close_eyes_right_click():
    global EAR
    global EYE_AR_THRESH
    global TOTAL
    global COUNTER
    #timing = time.time()

    while True:
        if EAR < EYE_AR_THRESH:
            COUNTER += 1
		# otherwise, the eye aspect ratio is not below the blink
		# threshold
        else:
			# if the eyes were closed for a sufficient number of
			# then increment the total number of blinks
			# EYE_AR_CONSEC_FRAMES
            if COUNTER >= EYE_AR_CONSEC_FRAMES:               
                TOTAL += 1
			# reset the eye frame counter
                COUNTER = 0
        #if time.time() - timing > DOUBLE_CLICK_TIMER:
           #timing = time.time()
           #print(EAR)
           #print(TOTAL_DOUBLE_CLICK_LEFT)
        if TOTAL >= 1:
           mouse.click('right')
           TOTAL = 0 

def right_eye_double_click():
    global EAR
    global DOUBLE_CLICK_RIGHT_COUNTER
    global TOTAL_DOUBLE_CLICK_RIGHT
    timing = time.time()

    while True:
        if EAR < EYE_AR_THRESH_RIGHT_CLICK:
            DOUBLE_CLICK_RIGHT_COUNTER += 1
		# otherwise, the eye aspect ratio is not below the blink
		# threshold
        else:
			# if the eyes were closed for a sufficient number of
			# then increment the total number of blinks
            if DOUBLE_CLICK_RIGHT_COUNTER >= EYE_AR_CONSEC_FRAMES:
                 TOTAL_DOUBLE_CLICK_RIGHT += 1
			# reset the eye frame counter
                 DOUBLE_CLICK_RIGHT_COUNTER = 0
        if time.time() - timing > DOUBLE_CLICK_TIMER:
           timing = time.time()
           #print(EAR)
           #print(TOTAL_DOUBLE_CLICK_RIGHT)
        if TOTAL_DOUBLE_CLICK_RIGHT >= 2:
           mouse.click('right')
           TOTAL_DOUBLE_CLICK_RIGHT = 0

def load_detector():
	global EYE_AR_THRESH
	global EYE_LEFT_AR_THRESH
	global EYE_RIGHT_AR_THRESH
	global EAR
	global COUNTER
	global TOTAL
	global LEFT_EYE_BLINK_COUNTER
	global LEFT_TOTAL
	global RIGHT_EYE_BLINK_COUNTER
	global RIGHT_TOTAL
# construct the argument parse and parse the arguments
	ap = argparse.ArgumentParser(description='Settings for eye detector')
#ap.add_argument("-p", "--shape-predictor", required=True, help="path to facial landmark predictor")
	ap.add_argument('Left_eye', type=int,  help='For which action responsible left eye')
	ap.add_argument('Right_eye', type=int,  help='For which action responsible right eye')
	ap.add_argument('Double_click_timer', type=float,  help='timer for double blinking')
#ap.add_argument("-v", "--video", type=str, default="",
#	help="path to input video file")
#args = vars(ap.parse_args())
	args = ap.parse_args()
	LEFT_EYE_SETTING = args.Left_eye
	RIGHT_EYE_SETTING = args.Right_eye
	DOUBLE_CLICK_TIMER = args.Double_click_timer

	print(LEFT_EYE_SETTING)
	print(RIGHT_EYE_SETTING)
	print(DOUBLE_CLICK_TIMER)


# initialize dlib's face detector (HOG-based) and then create
# the facial landmark predictor
	print("[INFO] loading facial landmark predictor...")
	detector = dlib.get_frontal_face_detector()
#predictor = dlib.shape_predictor(args["shape_predictor"])
	path_to_preictor = pathlib.Path().resolve()
	final_path = str(path_to_preictor) + "\shape_predictor_68_face_landmarks.dat"
	print("[INFO] path to shape predictor", final_path)
	predictor = dlib.shape_predictor(final_path)

# grab the indexes of the facial landmarks for the left and
# right eye, respectively
	(lStart, lEnd) = face_utils.FACIAL_LANDMARKS_IDXS["left_eye"]
	(rStart, rEnd) = face_utils.FACIAL_LANDMARKS_IDXS["right_eye"]

# start the video stream thread
	print("[INFO] starting video stream thread...")
#vs = FileVideoStream(args["video"]).start()
	fileStream = True
	vs = VideoStream(src=0).start()
#vs = VideoStream(usePiCamera=True).start()
	fileStream = False
	time.sleep(1.0)

	if LEFT_EYE_SETTING == 2:
		print("[INFO] double click for left click")
		left_eye_double_click_thread.daemon = True
		left_eye_double_click_thread.start()
	if LEFT_EYE_SETTING == 3:
		print("[INFO] close eyes for left click")
		close_eyes_left_click_thread.daemon = True
		close_eyes_left_click_thread.start()


	if RIGHT_EYE_SETTING == 2:
		print("[INFO] double click for right click")
		right_eye_double_click_thread.daemon = True
		right_eye_double_click_thread.start()
	if RIGHT_EYE_SETTING == 3:
		print("[INFO] double click for right click")
		close_eyes_right_click_thread.daemon = True
		close_eyes_right_click_thread.start()

# loop over frames from the video stream
	while True:
	# if this is a file video stream, then we need to check if
	# there any more frames left in the buffer to process
		if fileStream and not vs.more():
			break
	# grab the frame from the threaded video file stream, resize
	# it, and convert it to grayscale
	# channels)
		frame = vs.read()

		if frame is None:
			while frame is None:
				print("[INFO] frame is none...")
		#frame = vs.read()


	#frame = imutils.resize(frame, width=640)
		gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY) 
	# detect faces in the grayscale frame
		rects = detector(gray, 0)
	
    	# loop over the face detections
		for rect in rects:
		# determine the facial landmarks for the face region, then
		# convert the facial landmark (x, y)-coordinates to a NumPy
		# array
			shape = predictor(gray, rect)
			shape = face_utils.shape_to_np(shape)
		# extract the left and right eye coordinates, then use the
		# coordinates to compute the eye aspect ratio for both eyes
			leftEye = shape[lStart:lEnd]
			rightEye = shape[rStart:rEnd]
			leftEAR = eye_aspect_ratio(leftEye)
			rightEAR = eye_aspect_ratio(rightEye)
		# average the eye aspect ratio together for both eyes
		#ear = (leftEAR + rightEAR) / 2.0
			EAR = leftEAR + rightEAR
		
        # compute the convex hull for the left and right eye, then
		# visualize each of the eyes
			leftEyeHull = cv2.convexHull(leftEye)
			rightEyeHull = cv2.convexHull(rightEye)
			cv2.drawContours(frame, [leftEyeHull], -1, (0, 255, 0), 1)
			cv2.drawContours(frame, [rightEyeHull], -1, (255, 0, 0), 1)
		
        		# check to see if the eye aspect ratio is below the blink
		# threshold, and if so, increment the blink frame counter
#			if EAR < EYE_AR_THRESH:
#				COUNTER += 1
		# otherwise, the eye aspect ratio is not below the blink
		# threshold
#			else:
			# if the eyes were closed for a sufficient number of
			# then increment the total number of blinks
#				if COUNTER >= EYE_AR_CONSEC_FRAMES:
#					TOTAL += 1
			# reset the eye frame counter
#				COUNTER = 0

			if EAR > EYE_AR_THRESH and leftEAR < EYE_LEFT_AR_THRESH and rightEAR > EYE_RIGHT_AR_THRESH:
				LEFT_EYE_BLINK_COUNTER += 1

			if EAR < EYE_AR_THRESH and leftEAR < EYE_LEFT_BELOW_AR_THRESH and rightEAR > EYE_RIGHT_BELOW_AR_THRESH:
				LEFT_EYE_BLINK_COUNTER += 1
			else:
				if LEFT_EYE_BLINK_COUNTER >= EYE_AR_CONSEC_FRAMES and LEFT_EYE_SETTING == 0:
					LEFT_TOTAL +=1
					mouse.click('left')
					LEFT_EYE_BLINK_COUNTER = 0

				if LEFT_EYE_BLINK_COUNTER >= EYE_AR_CONSEC_FRAMES and LEFT_EYE_SETTING == 1:
					LEFT_TOTAL +=1
					mouse.click('right')
					LEFT_EYE_BLINK_COUNTER = 0


			if EAR > EYE_AR_THRESH and rightEAR < EYE_RIGHT_AR_THRESH and leftEAR > EYE_LEFT_AR_THRESH:
				RIGHT_EYE_BLINK_COUNTER += 1
			if EAR < EYE_AR_THRESH and rightEAR < EYE_RIGHT_BELOW_AR_THRESH and leftEAR > EYE_LEFT_BELOW_AR_THRESH:
				RIGHT_EYE_BLINK_COUNTER += 1
			else:
				if RIGHT_EYE_BLINK_COUNTER >= EYE_AR_CONSEC_FRAMES and RIGHT_EYE_SETTING == 0:
					RIGHT_TOTAL +=1
					mouse.click('left')
					RIGHT_EYE_BLINK_COUNTER = 0

				if RIGHT_EYE_BLINK_COUNTER >= EYE_AR_CONSEC_FRAMES and RIGHT_EYE_SETTING == 1:
					RIGHT_TOTAL +=1
					mouse.click('right')
					RIGHT_EYE_BLINK_COUNTER = 0
			
        # draw the total number of blinks on the frame along with
		# the computed eye aspect ratio for the frame
			cv2.putText(frame, "Blinks: {}".format(TOTAL), (10, 30),
				cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 0, 255), 2)
			cv2.putText(frame, "EAR: {:.2f}".format(EAR), (300, 30),
				cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 0, 255), 2)
		
			cv2.putText(frame, "Left eye blink: {}".format(LEFT_EYE_BLINK_COUNTER), (10, 200),
				cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 0, 255), 2)
			cv2.putText(frame, "Left ear: {:.2f}".format(leftEAR), (10, 250),
				cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 0, 255), 2)
		
			cv2.putText(frame, "Right eye blink: {}".format(RIGHT_EYE_BLINK_COUNTER), (250, 200),
				cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 0, 255), 2)
			cv2.putText(frame, "Right ear: {:.2f}".format(rightEAR), (250, 250),
				cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 0, 255), 2)
 
	# show the frame
		#cv2.imshow("Frame", frame)
		#key = cv2.waitKey(1) & 0xFF
 
	# if the `q` key was pressed, break from the loop
		#if key == ord("q"):

		#	break
# do a bit of cleanup
	cv2.destroyAllWindows()
	vs.stop()

	

eye_detector_thread = Thread(target = load_detector)
left_eye_double_click_thread = Thread(target = left_eye_double_click) 
right_eye_double_click_thread = Thread(target = right_eye_double_click)
close_eyes_left_click_thread = Thread(target = close_eyes_left_click)
close_eyes_right_click_thread = Thread(target = close_eyes_right_click)

eye_detector_thread.start()



