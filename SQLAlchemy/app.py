from flask import Flask, jsonify
import numpy as np

import sqlalchemy
from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session
from sqlalchemy import create_engine, func

import datetime as dt
from datetime import datetime

app = Flask(__name__)

engine = create_engine("sqlite:///Resources/hawaii.sqlite")
Base = automap_base()
# reflect the tables
Base.prepare(engine, reflect=True)

# Save reference to the table
Measurement = Base.classes.measurement
Station = Base.classes.station
session = Session(engine)


@app.route("/")
def home():
    return "hi from prachi"

@app.route('/hello/<name>')
def Home():
    """List all available api routes."""
    return (
        f"Available Routes:<br/>"
        f"/api/v1.0/precipitation<br/>"
        f"/api/v1.0/stations<br/>"
        f"/api/v1.0/tobs<br/>"
        f"/api/v1.0/<start><br/>"
        f"/api/v1.0/<start>/<end><br/>"
    )

@app.route("/api/v1.0/precipitation")
def precipitation():

    str_date=session.query(Measurement.date).order_by(Measurement.date.desc()).first()[0]
    str_date=datetime.strptime(str_date, '%Y-%m-%d') - dt.timedelta(days=365)
    precipitation_data = session.query(Measurement.date, Measurement.prcp).\
                        filter(Measurement.date > str_date).all()
    
    all_measurements = []
    for date, prcp in precipitation_data:
        precipitation_dict = {}
        precipitation_dict["date"] = date
        precipitation_dict["prcp"] = prcp
        all_measurements.append(precipitation_dict)
    

    return jsonify(all_measurements)

@app.route("/api/v1.0/station")
def stations():
        stationlist = session.query(Station.station).all()
        return jsonify(stationlist)

@app.route("/api/v1.0/tobs")
def tobs():

    str_date=session.query(Measurement.date).order_by(Measurement.date.desc()).first()[0]
    str_date=datetime.strptime(str_date, '%Y-%m-%d') - dt.timedelta(days=365)
    tobs_data = session.query(Measurement.date, Measurement.tobs).\
                        filter(Measurement.date > str_date).all()
    
    all_measurements = []
    for date, tobs in tobs_data:
        tobs_dict = {}
        tobs_dict["date"] = date
        tobs_dict["tobs"] = tobs
        all_measurements.append(tobs_dict)

        return jsonify(all_measurements)

@app.route('/api/v1.0/<start_date>')
def start_stats(start_date):

    str_date=datetime.strptime(start_date, '%Y-%m-%d') - dt.timedelta(days=366)
    minimum = session.query(Measurement.tobs, func.min(Measurement.tobs)).filter(Measurement.date >= str_date)
    maximum = session.query(Measurement.tobs, func.max(Measurement.tobs)).filter(Measurement.date >= str_date)
    average = session.query(Measurement.tobs, func.avg(Measurement.tobs)).filter(Measurement.date >= str_date)

    start_temp = {"Tmin": minimum[0][0], "Tmax": maximum[0][0], "Tavg": average[0][0]}
    
    
    return jsonify(start_temp)

@app.route("/api/v1.0/<start_date>&<end_date>")
def start(start_date, end_date):
    #When given the start only, calculate TMIN, TAVG, and TMAX for all dates greater than and equal to the start date."
    str_date=datetime.strptime(start_date, '%Y-%m-%d') - dt.timedelta(days=366)
    end_date=datetime.strptime(end_date, '%Y-%m-%d') - dt.timedelta(days=366)

    minimum = session.query(Measurement.tobs, func.min(Measurement.tobs)).filter(Measurement.date.between(str_date, end_date))
    maximum = session.query(Measurement.tobs, func.max(Measurement.tobs)).filter(Measurement.date.between(str_date, end_date))
    average = session.query(Measurement.tobs, func.avg(Measurement.tobs)).filter(Measurement.date.between(str_date, end_date))
    start_end_temps = {"Tmin": minimum[0][0], "Tmax": maximum[0][0], "Tavg": average[0][0]}
    
    return jsonify(start_end_temps)


if __name__ == "__main__":
    app.run(debug=True)
